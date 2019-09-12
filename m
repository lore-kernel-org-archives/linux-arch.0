Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:47:50 -0400
From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Multidrop support
Date: Thu, 12 Sep 2019 10:40:30 +0200
Message-Id: <20190912084032.16927-1-giometti@enneenne.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Richard Genoud <richard.genoud@gmail.com>


Here are two patches to introduce multidrop support.

First one defines new termios bits useful to enable multidrop support,
while the second one effectively implements multidrop for the
Atmel/Microchip serial controllers.

Of course other serial drivers can do similar steps if the hardware
they control can do similar operations.

Rodolfo
