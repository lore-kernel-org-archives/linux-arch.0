From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 2/2] tty/serial: atmel: add ISO7816 support
Date: Mon, 10 Sep 2018 15:19:58 +0200
Message-ID: <ea441610-1337-d14c-7171-f0fac158bd9a@sorico.fr>
References: <20180906134214.29031-1-ludovic.desroches@microchip.com>
 <20180906134214.29031-3-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906134214.29031-3-ludovic.desroches@microchip.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
