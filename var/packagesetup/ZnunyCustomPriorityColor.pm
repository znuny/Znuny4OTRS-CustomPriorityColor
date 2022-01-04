# --
# Copyright (C) 2012-2022 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::packagesetup::ZnunyCustomPriorityColor;    ## no critic

use strict;
use warnings;

use utf8;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::SysConfig',
    'Kernel::System::ZnunyHelper',
);

use Kernel::System::VariableCheck qw(:all);

=head1 NAME

var::packagesetup::ZnunyCustomPriorityColor - code to execute during package installation

=head1 SYNOPSIS

All code to execute during package installation

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    my $CodeObject    = $Kernel::OM->Get('var::packagesetup::ZnunyCustomPriorityColor');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');

    $ZnunyHelperObject->_RebuildConfig();

    return $Self;
}

=head2 CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    return 1;
}

=head2 CodeUpgradeForLowerThan603()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgradeForLowerThan603();

=cut

sub CodeUpgradeForLowerThan603 {
    my ( $Self, %Param ) = @_;

    my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');
    my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

    my $PriorityNamesToColor = $ConfigObject->Get('CustomPriorityColor::PriorityColor') || {};
    return 1 if !$PriorityNamesToColor;

    my %NewPriorityNamesToColor;
    for my $Priority ( sort keys %{$PriorityNamesToColor} ) {
        my $Color = $PriorityNamesToColor->{$Priority};

        $Color =~ s{^(\w{3,6})$}{#$1}xms;
        $NewPriorityNamesToColor{$Priority} = $Color;
    }

    $SysConfigObject->SettingsSet(
        Settings => [
            {
                Name           => 'CustomPriorityColor::PriorityColor',
                IsValid        => 1,
                EffectiveValue => \%NewPriorityNamesToColor,
            },
        ],
        UserID => 1,
    );

    return 1;
}

=head2 CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    return 1;
}

1;
