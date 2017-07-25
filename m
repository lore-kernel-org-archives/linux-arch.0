From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] devicetree: cleanup and improve DT cross-arch reference
Date: Tue, 25 Jul 2017 11:23:33 +0900
Message-ID: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Masahiro Yamada (3):
  of: remove drivers/of/testcase-data from include search path for CPP
  of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
  of: search scripts/dtc/include-prefixes path for both CPP and DTC

 scripts/Makefile.lib | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

