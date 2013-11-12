From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/11] Add generic fixmap.h
Date: Tue, 12 Nov 2013 14:46:40 +0100
Message-ID: <201311121446.40700.arnd@arndb.de>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <1384262545-20875-2-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384262545-20875-2-git-send-email-msalter@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, microblaze-uclinux@itee.uq.edu.au, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 12 November 2013, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.h
> which is intended to be included from arch/*/include/asm/fixmap.h.


Good idea, 

Acked-by: Arnd Bergmann <arnd@arndb.de>

On Tuesday 12 November 2013, Mark Salter wrote:
> +static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> +{
> +       /*
> +        * this branch gets completely eliminated after inlining,
> +        * except when someone tries to use fixaddr indices in an
> +        * illegal way. (such as mixing up address types or using
> +        * out-of-range indices).
> +        *
> +        * If it doesn't get removed, the linker will complain
> +        * loudly with a reasonably clear error message..
> +        */
> +       if (idx >= __end_of_fixed_addresses)
> +               __this_fixmap_does_not_exist();
> +

You might be able to turn this into the more readable BUILD_BUG_ON().

	Arnd
