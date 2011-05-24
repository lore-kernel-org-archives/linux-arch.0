From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: (Short?) merge window reminder
Date: Tue, 24 May 2011 10:36:17 -0700
Message-ID: <4DDBEC91.8020004@zytor.com>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>	<20110523192056.GC23629@elte.hu>	<BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>	<20110523231721.GM10009@thunk.org>	<4DDAEC68.30803@zytor.com>	<BANLkTikGfVSAMY2a2yiXaNpvBVvF8YdMEA@mail.gmail.com>	<alpine.LNX.2.01.1105241409280.15351@frira.zrqbmnf.qr>	<BANLkTimCXVdVa6KLRG8GJR1gJY=7_5SkOA@mail.gmail.com>	<alpine.LNX.2.01.1105241500410.23085@frira.zrqbmnf.qr>	<BANLkTinNK+9XijCN0YGXyvLQ8_npPTG2cQ@mail.gmail.com>	<20110524154348.27ba649d@lxorguk.ukuu.org.uk>
	<BANLkTi=Xuk4=Q43QV1pv33K=J2FFZBLLtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <BANLkTi=Xuk4=Q43QV1pv33K=J2FFZBLLtQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-arch@vger.kernel.org, Ted Ts'o <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.medozas.de>, Jan Engelhardt <jengelh@medozas.de>, Jacek Luczak <difrost.kernel@gmail.com>, DRI <dri-devel@lists.freedesktop.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On 05/24/2011 08:07 AM, jonsmirl@gmail.com wrote:
> On Tue, May 24, 2011 at 10:43 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Can we drop most of MCA, EISA and ISA bus if we are going to have a big
>> version change ? A driver spring clean is much overdue and it's all in
>> git in case someone wishes to sneak out at midnight and bring some crawly
>> horror back from the dead.
> 
> 2.8 could mark the beginning of the great cleanup
>   --- work out the details of what needs to be cleaned and set a goal
>   --- remove old buses/driver, switch to device tree, graphics, 32/64
> merges, etc
> 3.0 would mark its completion
> 

I think this whole discussion misses the essence of the new development
model, which is that we no longer do these kinds of feature-based major
milestones.  If we want to to deprecate lots of drivers (which I
personally would advocate against -- I have built systems specifically
to run a real floppy drive since the Linux floppy driver is amazingly
flexible and can read/write a lot of formats that nothing else can,
including USB floppies) then we should do that in the normal course of
action, incrementally, and listed in feature-removal-schedule.txt, not
all at once due to some arbitrary milestone.

We have found it works better this way.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
