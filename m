From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 16:38:36 +0100
Message-ID: <20160321153836.GZ6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3cec9e..37afd721ec99 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -887,8 +887,8 @@ static void check_section(const char *modname, struct elf_info *elf,
>  #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>  
>  #define DATA_SECTIONS ".data", ".data.rel"
> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
> -		".kprobes.text"
> +#define TEXT_SECTIONS ".text", ".text.unlikely", \
> +		".kprobes.text", ".cpuidle.text"

Where did .sched.text go?

>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
>  		".fixup", ".entry.text", ".exception.text", ".text.*", \
>  		".coldtext"
