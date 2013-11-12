From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
Date: Tue, 12 Nov 2013 10:55:11 -0500
Message-ID: <1384271711.24631.5.camel@deneb.redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <52824BBC.9020401@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52824BBC.9020401@monstr.eu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: monstr@monstr.eu
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, microblaze-uclinux@itee.uq.edu.au, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
> On 11/12/2013 02:22 PM, Mark Salter wrote:
> > 
> >  arch/arm/include/asm/fixmap.h        |  25 ++------
> >  arch/hexagon/include/asm/fixmap.h    |  40 +------------
> >  arch/metag/include/asm/fixmap.h      |  32 +----------
> >  arch/microblaze/include/asm/fixmap.h |  44 +-------------
> >  arch/mips/include/asm/fixmap.h       |  33 +----------
> >  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
> >  arch/sh/include/asm/fixmap.h         |  39 +------------
> >  arch/tile/include/asm/fixmap.h       |  33 +----------
> >  arch/um/include/asm/fixmap.h         |  40 +------------
> >  arch/x86/include/asm/fixmap.h        |  59 +------------------
> >  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
> >  11 files changed, 125 insertions(+), 371 deletions(-)
> >  create mode 100644 include/asm-generic/fixmap.h
> 
> Any repo/branch with all these patches will be helpful.

https://github.com/mosalter/linux (fixmap branch)
