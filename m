From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 3/3] sched: depend on 64BIT_ATOMIC_ACCESS to determine if
 to use min_vruntime_copy
Date: Thu, 24 Aug 2017 10:49:06 +0200
Message-ID: <20170824084906.mtmj6rz4igo63dl5@hirez.programming.kicks-ass.net>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
 <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Kees Cook <keescook@chromium.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, mic@digikod.net, Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Jonathan Austin <jonathan.austin@arm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 24, 2017 at 02:42:57PM +0900, Hoeun Ryu wrote:
> +#ifndef CONFIG_64BIT_ATOMIC_ALIGNED_ACCESS
>  	u64 min_vruntime;
> -#ifndef CONFIG_64BIT
> +#else
> +	u64 min_vruntime __attribute__((aligned(sizeof(u64))));
> +#endif

That's stupid, just make sure your platform defines u64 as naturally
aligned when you have this 64BIT_ATOMIC foo.

Also, please try and dig out more 32bit archs that can use this and make
sure to include performance numbers to justify this extra cruft.
