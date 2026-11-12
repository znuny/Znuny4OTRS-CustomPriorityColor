# --
# Copyright (C) 2012 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::hu_ZnunyCustomPriorityColor;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # SysConfig
    $Self->{Translation}->{'Mapping of ticket priority name to background color.'} = 'Jegyprioritás nevének leképezése háttérszínre.';
    $Self->{Translation}->{'Output filter to add CSS for ticket priorities.'} = 'Kimenetszűrő a jegyprioritásokhoz való CSS hozzáadásához.';


    push @{ $Self->{JavaScriptStrings} //= [] }, (
    );

}

1;
