# --
# Copyright (C) 2012-2020 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Kernel::System::VariableCheck qw(:all);

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);

my $PackageSetupObject = $Kernel::OM->Get('var::packagesetup::Znuny4OTRSCustomPriorityColor');
my $ConfigObject       = $Kernel::OM->Get('Kernel::Config');
my $SysConfigObject    = $Kernel::OM->Get('Kernel::System::SysConfig');

$Self->True(
    scalar $PackageSetupObject->CodeInstall(),
    'CodeInstall()',
);

$Self->True(
    scalar $PackageSetupObject->CodeReinstall(),
    'CodeReinstall()',
);

$Self->True(
    scalar $PackageSetupObject->CodeUpgrade(),
    'CodeUpgrade()',
);

$Self->True(
    scalar $PackageSetupObject->CodeUninstall(),
    'CodeUninstall',
);

$SysConfigObject->SettingsSet(
    Settings => [
        {
            Name           => 'CustomPriorityColor::PriorityColor',
            IsValid        => 1,
            EffectiveValue => {
                '1 very low'  => 'aabbff',
                '2 low'       => 'aaddff',
                '3 normal'    => 'cdcdcd',
                '4 high'      => 'ffcccc',
                '5 very high' => 'ffaaaa',
            },
        },
    ],
    UserID => 1,
);

$ConfigObject->Set(
    Key   => 'CustomPriorityColor::PriorityColor',
    Value => {
        '1 very low'  => 'aabbff',
        '2 low'       => 'aaddff',
        '3 normal'    => 'cdcdcd',
        '4 high'      => 'ffcccc',
        '5 very high' => 'ffaaaa',
    },
);
$ConfigObject = $Kernel::OM->Get('Kernel::Config');


my $PriorityNamesToColor = $ConfigObject->Get('CustomPriorityColor::PriorityColor') || {};

$Self->IsDeeply(
    $PriorityNamesToColor,
    {

        '1 very low'  => 'aabbff',
        '2 low'       => 'aaddff',
        '3 normal'    => 'cdcdcd',
        '4 high'      => 'ffcccc',
        '5 very high' => 'ffaaaa',
    },
    'CustomPriorityColor::PriorityColor - old',
);

$Self->True(
    scalar $PackageSetupObject->CodeUpgradeForLowerThan603(),
    'CodeUpgradeForLowerThan603()',
);

$Kernel::OM->ObjectsDiscard(
    Objects => ['Kernel::Config'],
);

$ConfigObject = $Kernel::OM->Get('Kernel::Config');

$PriorityNamesToColor = $ConfigObject->Get('CustomPriorityColor::PriorityColor') || {};

$Self->IsDeeply(
    $PriorityNamesToColor,
    {

        '1 very low'  => '#aabbff',
        '2 low'       => '#aaddff',
        '3 normal'    => '#cdcdcd',
        '4 high'      => '#ffcccc',
        '5 very high' => '#ffaaaa',
    },
    'CustomPriorityColor::PriorityColor - new',
);

1;
