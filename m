From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 05/11] ARM: at91: convert timer suspend/resume to
 clock_event_device
Date: Mon, 12 Nov 2012 15:49:36 +0100
Message-ID: <20121112144936.GL4576@game.jcrosoft.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 14:01 Thu 08 Nov     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move at91's timer suspend/resume functions from struct sys_timer
> at91sam926x_timer into struct clock_event_device pit_clkevt. This
> will allow the sys_timer suspend/resume fields to be removed, and
> eventually lead to a complete removal of struct sys_timer.
> 
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
look fine

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
