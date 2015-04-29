From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v9,14/17] serial: Add H8300.
Date: Wed, 29 Apr 2015 09:47:54 -0700
Message-ID: <20150429164754.GA1695@roeck-us.net>
References: <1430112924-1134-15-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430112924-1134-15-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 27, 2015 at 02:35:21PM +0900, Yoshinori Sato wrote:
> h8300 internal serial controller of same as sh-sci.
> So h8300 use SH_SCI.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> ---
> drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f8120c1..130f201 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -728,7 +728,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
>  
>  config SERIAL_SH_SCI
>  	tristate "SuperH SCI(F) serial port support"
> -	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> +	depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST 

This adds a trailing whitespace.

Guenter
