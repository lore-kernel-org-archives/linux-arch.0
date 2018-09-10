Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.141]:50010 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbeIJSOG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Sep 2018 14:14:06 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id BD3F221098
        for <linux-arch@vger.kernel.org>; Mon, 10 Sep 2018 15:20:00 +0200 (CEST)
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <ea441610-1337-d14c-7171-f0fac158bd9a@sorico.fr>
Date: Mon, 10 Sep 2018 15:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180906134214.29031-3-ludovic.desroches@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
Message-ID: <20180910131958._ORVhmW5sZILqxi6KVjfzcL_2KrU2yqwTLg9_sIs7mw@z>

Hi, Ludovic,

On 06/09/2018 15:42, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> When mode is set in atmel_config_iso7816() we backup last RS232 mode
> for coming back to this mode if requested.
> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
> function as well.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

This seems ok for me.

Acked-by: Richard Genoud <richard.genoud@gmail.com>

Thanks !
