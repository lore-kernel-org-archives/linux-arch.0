From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Date: Sat, 29 Oct 2016 23:02:40 +0200
Message-ID: <2502005.4risrb1P1I@wuerfel>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Mark Salter <msalter@redhat.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Jonas Bonn <jonas@southpole.se>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, nios2-dev@lists.rocketboards.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Pinski <Andrew.Pinski@cavium.com>, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>
List-Id: linux-arch.vger.kernel.org

On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
> 
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all
> architectures using the generic syscall list to define it so that no
> in-tree architectures are affected.

The patch looks good, but shouldn't we also hide the actual syscall
implementation if the symbol is not set? It's just dead code otherwise
for new architectures.

	Arnd
