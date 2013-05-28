From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arch: arm64: kernel: sprintf(), 'str' needs
 additional 1 byte for failure processing
Date: Tue, 28 May 2013 11:42:50 +0100
Message-ID: <20130528104250.GE10474@mudshark.cambridge.arm.com>
References: <51A1E3B3.4060901@asianux.com>
 <51A2BE2C.2000004@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51A2BE2C.2000004@asianux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hello,

On Mon, May 27, 2013 at 03:00:12AM +0100, Chen Gang wrote:
> 
> When failure occurs at the last looping cycle (when 'i == 0'), it will
> print "bad PC value" instead of "(%08x) ", which needs additional 1
> byte.
> 
> If not add 1 byte, the 'str' may be memory overflow.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/traps.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 61d7dd2..c2f68d2 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -100,7 +100,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  {
>  	unsigned long addr = instruction_pointer(regs);
>  	mm_segment_t fs;
> -	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
> +	char str[sizeof("00000000 ") * 5 + 2 + 1 + 1], *p = str;
>  	int i;

Whilst this code is difficult to follow, I don't think it's incorrect.
The size of the str array is:

	sizeof("00000000 ") = 8 ('0's) + 1 (space) + 1 (NUL) = 10 bytes
	*5 = 50 bytes
	+2 (for the two brackets when i == 0) = 52 bytes
	+1 (this is for the "bad PC value") = 53 bytes

In the worst case (when the PC is bad) we print:

	"%08x " x4 = (8 + 1 + 1) *4 = 40 bytes
	"bad PC value" = 12 + 1 = 13 bytes

so again, 53 bytes.

... or have I missed a character somewhere?

Will
