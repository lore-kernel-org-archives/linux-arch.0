From: Jeff Kirsher <tarbal@gmail.com>
Subject: Re: [PATCH v6 11/16] h8300: clock driver
Date: Mon, 09 Mar 2015 02:13:31 -0700
Message-ID: <54FD643B.7010309@gmail.com>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp> <1425890830-29399-12-git-send-email-ysato@users.sourceforge.jp>
Reply-To: jeffrey.t.kirsher@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42902 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbbCIJNg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 05:13:36 -0400
In-Reply-To: <1425890830-29399-12-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 03/09/2015 01:47 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp> --- 
> drivers/clk/Makefile            |   1 + drivers/clk/h8300/Makefile
> |   2 + drivers/clk/h8300/clk-h83069.c  |  80 +++++++++++++++++++ 
> drivers/clk/h8300/clk-h8s2678.c | 171
> ++++++++++++++++++++++++++++++++++++++++ 
> include/linux/clk-provider.h    |  12 +++ 5 files changed, 266
> insertions(+) create mode 100644 drivers/clk/h8300/Makefile create
> mode 100644 drivers/clk/h8300/clk-h83069.c create mode 100644
> drivers/clk/h8300/clk-h8s2678.c

A lot of changes and no patch description?  A patch description needs
to explain "why" the change.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/WQ6AAoJEOVv75VaS+3OXawP/1XHsE3bRsgoj7ltL23+kuuh
RKNOMd/RcjtZTr86pdvtbzLPvl7i/KOFTHGOqGIfzPKMKPF4a+QFQF0884zy4Cp8
QVasL8pi+JmCZI3OPT0EUQ4lte8GUmqn0AXdcIokAS0SdU5iG7iaeO3RcZaxY8/F
jxWnSPD/tHPJZ8r8ZQvbpcDAJ6kMxj4vdipJHO0y1VJPOm/80mDX6Gu9IwEp1zIv
52HECPc/jmXHPPBshh33jZYlEztsQxyENR2TPNPW0YS74hdL6+LwkqZ04xHdXhLX
XuRVBI3+ysjzcQOHB18ZGBnO4So7o/McGJBj6s39i6KT9q0mfFFHBTPgvCDIeg+e
PNiILipr6RYv/K305Yu+z71o3M0jJ6+qSFpNDPPs/OwUfbAidM86+MDOOJDYaqmK
ZWghA82w2IXebZcq/5V/RUzSkbSfKtTX++V7yNhY4d1aUo4olG0eUU6AKW/NpuRm
1W4M55PD52I6u6cpS7W5B7FeNrdJtHqH1pJBW4e3AcC92S+aYSSsNxx9eXRAprZo
Ya5JVhl3NmW/JI6Eq/+mWLofwk5TwjIaujysmZOdX1KIu3W4r8XVqrDsVPGIC9ro
weGSddjE3cPV53KTX/Ld/hNq8/soRllqVZ/9Vtz7QkYqQsoW6HiVQ9f/KRC8oTTA
qlFqIG8L5BaDyW1Ayxs/
=NyEB
-----END PGP SIGNATURE-----
