From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC 3/3] asm-generic: Drop renameat syscall from
	default list
Date: Wed, 14 May 2014 17:16:57 +0100
Message-ID: <537396F9.3090704@imgtec.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>	<1398247687-13453-4-git-send-email-james.hogan@imgtec.com>	<201404231418.05174.arnd@arndb.de>	<CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
	<CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Szeredi Miklos <miklos@szeredi.hu>
Cc: linux-arch@vger.kernel.org, Miklos Szeredi <mszeredi@suse.cz>, linux-c6x-dev@linux-c6x.org, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <a-jacquiot@ti.com>, Vineet Gupta <vgupta@synopsys.com>, linux@openrisc.net, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>, Richard Kuo <rkuo@codeaurora.org>, Lennox Wu <lennox.wu@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chen Liqin <liqin.linux@gmail.com>, metag <linux-metag@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Miklos,

On 29/04/14 12:24, Szeredi Miklos wrote:
> On Wed, Apr 23, 2014 at 2:41 PM, James Hogan <james.hogan@imgtec.com> wrote:
> 
>> It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
>> syscall to asm-generic unistd.h), and will be submitting it to Linus
>> at some point as part of his renameat2 series.
>> Miklos: Do you think it makes sense for you to include my second patch
>> in your series too since it's renameat2 related?
>> http://marc.info/?l=linux-kernel&m=139824773305016&w=2
> 
> I've queued up the first two patches with acks from Arnd.

Were you planning to send a pull request for your renameat2 patches for
v3.15?

Cheers
James
