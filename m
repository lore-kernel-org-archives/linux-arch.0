From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
Date: Sun, 23 Dec 2012 11:11:18 +0000
Message-ID: <20121223111118.GC16237@mudshark.cambridge.arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <50D4671F.1010003@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <50D4671F.1010003@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "aarcange@redhat.com" <aarcange@redhat.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "tawfik@marvell.com" <tawfik@marvell.com>, "bill4carson@gmail.com" <bill4carson@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Steve Capper <Steve.Capper@arm.com>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "maen@marvell.com" <maen@marvell.com>, Lior Amsalem <alior@marvell.com>, "hoffman@marvell.com" <hoffman@marvell.com>, "notasas@gmail.com" <notasas@gmail.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shadi@marvell.com" <shadi@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 21, 2012 at 01:41:51PM +0000, Gregory CLEMENT wrote:
> On 10/18/2012 06:15 PM, Steve Capper wrote:
> > Hello,
> Hi Steve,

Hi Gregory,

> I resurrected this old thread to have some news about this subject.
> We are interested to get this support for the Armada 370/XP based boards.
> 
> I am surprised that there wasn't any feedback on this series. We are
> willing to help this feature being merge in the kernel.
> 
> Testing your series on the board we have could help you?

Whilst testing is always welcome, the thing this code *really* needs is some
proper review, especially for the implementation for 3-level page tables. We
tested pretty extensively on v6, v7 and v7+lpae platforms ourselves but, of
course, if you do uncover an issue then please shout.

Will
