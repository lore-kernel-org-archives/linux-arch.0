From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] asm-generic: add sched_setattr/sched_getattr
	syscalls
Date: Mon, 17 Feb 2014 18:44:35 +0000
Message-ID: <20140217184435.GD8361@arm.com>
References: <1391441617-21518-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
Content-Disposition: inline
In-Reply-To: <1391441617-21518-1-git-send-email-james.hogan@imgtec.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: James Hogan <james.hogan@imgtec.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <a-jacquiot@ti.com>, Vineet Gupta <vgupta@synopsys.com>, "linux@openrisc.net" <linux@openrisc.net>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>, Richard Kuo <rkuo@codeaurora.org>, Lennox Wu <lennox.wu@gmail.com>, "msalter@redhat.com" <msalter@redhat.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Liqin <liqin.linux@gmail.com>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 03, 2014 at 03:33:37PM +0000, James Hogan wrote:
> Add the sched_setattr and sched_getattr syscalls to the generic syscall
> list, which is used by the following architectures: arc, arm64, c6x,
> hexagon, metag, openrisc, score, tile, unicore32.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-metag@vger.kernel.org
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux@lists.openrisc.net
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
