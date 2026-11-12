# --
# Copyright (C) 2012 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_ZnunyCustomPriorityColor;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # SysConfig
    $Self->{Translation}->{'Mapping of ticket priority name to background color.'} = 'Mapping der Priorität-Namen des Tickets zur Hintergrundfarbe.';
    $Self->{Translation}->{'Output filter to add CSS for ticket priorities.'} = 'Output-Filter zum Hinzufügen von CSS für Ticket Prioritäten.';


    push @{ $Self->{JavaScriptStrings} //= [] }, (
    );

}

1;
