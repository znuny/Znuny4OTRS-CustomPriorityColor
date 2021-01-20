# --
# Copyright (C) 2012-2021 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::CustomPriorityColor;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Priority',
);

use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = \%Param;
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get Objects
    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $PriorityObject = $Kernel::OM->Get('Kernel::System::Priority');
    my $LogObject      = $Kernel::OM->Get('Kernel::System::Log');

    # get priority IDs to color
    my $PriorityNamesToColor = $ConfigObject->Get('CustomPriorityColor::PriorityColor') || {};

    return if !IsHashRefWithData($PriorityNamesToColor);

    # build the CSS out of the hash
    my $PriorityIDCSS = '<style type="text/css">
        /* overwrite priority id color */
        ';

    my %PriorityList = $PriorityObject->PriorityList(
        Valid => 1,
    );

    return if !%PriorityList;
    my %PriorityListReverse = reverse %PriorityList;

    my $PriorityID;
    PRIORITY:
    for my $PriorityName ( sort keys %PriorityListReverse ) {

        if ( !defined( $PriorityNamesToColor->{$PriorityName} ) ) {

            $LogObject->Log(
                Priority => 'error',
                Message  => "Can't set new color for priority $PriorityName",
            );
            next PRIORITY;
        }

        $PriorityIDCSS .= ".PriorityID-$PriorityListReverse{$PriorityName} {
            background-color: $PriorityNamesToColor->{$PriorityName} !important;
        }
        ";
    }

    $PriorityIDCSS .= '</style>
    ';

    # insert the CSS into the template
    ${ $Param{Data} } =~ s{(\<\/head\>)}{$PriorityIDCSS$1}xms;

    return 1;

}
1;
