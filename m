From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 22/73] alpha: don't use module_init for non-modular core
 code
Date: Tue, 21 Jan 2014 16:32:29 -0800
Message-ID: <52DF119D.6090506@twiddle.net>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-23-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1390339396-3479-23-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 01/21/2014 01:22 PM, Paul Gortmaker wrote:
> The srm console is always built in.  It will never be modular,
> so using module_init as an alias for __initcall is rather
> misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Direct use of __initcall is discouraged, vs prioritized ones.
> Use of device_initcall is consistent with what __initcall
> maps onto, and hence does not change the init order, making the
> impact of this change zero.   Should someone with real hardware
> for boot testing want to change it later to arch_initcall or
> console_initcall, they can do that at a later date.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/alpha/kernel/srmcons.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
