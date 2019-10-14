From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] sh: Move cmpxchg-xchg.h to asm-generic
Date: Mon, 14 Oct 2019 09:25:46 +0200
Message-ID: <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
References: <20191013221310.30748-1-sebastian@breakpoint.cc>
 <20191013221310.30748-2-sebastian@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191013221310.30748-2-sebastian@breakpoint.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-arch <linux-arch@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 14, 2019 at 12:13 AM Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
>
> The header file is very generic and could be reused by other
> architectures as long as they provide __cmpxchg_u32().
>
> Move sh's cmpxchg-xchg.h to asm-generic.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Maybe change the "#ifndef __ASM_SH_CMPXCHG_XCHG_H"
to __ASM_GENERIC_*.

        Arnd
