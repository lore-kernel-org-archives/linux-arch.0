From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: (Short?) merge window reminder
Date: Mon, 23 May 2011 16:33:12 -0700
Message-ID: <BANLkTikGfVSAMY2a2yiXaNpvBVvF8YdMEA@mail.gmail.com>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
	<20110523192056.GC23629@elte.hu>
	<BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
	<20110523231721.GM10009@thunk.org> <4DDAEC68.30803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <4DDAEC68.30803@zytor.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Ted Ts'o <tytso@mit.edu>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Another advantage of switching numbering models (ie 3.0 instead of
2.8.x) would be that it would also make the "odd numbers are also
numbers" transition much more natural.

Because of our historical even/odd model, I wouldn't do a 2.7.x -
there's just too much history of 2.1, 2.3, 2.5 being development
trees. But if I do 3.0, then I'd be chucking that whole thing out the
window, and the next release would be 3.1, 3.2, etc..

And then in another few years (probably before getting close to 3.40,
so I'm not going to make a big deal of 3 = "third decade"), I'd just
do 4.0 etc.

Because all our releases are supposed to be stable releases these
days, and if we get rid of one level of numbering, I feel perfectly
fine with getting rid of the even/odd history too.

                      Linus
