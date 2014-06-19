From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [REPOST PATCH 1/8] fence: dma-buf cross-device synchronization
 (v17)
Date: Thu, 19 Jun 2014 16:08:08 -0700
Message-ID: <1403219288.1962.17.camel@jarvis.lan>
References: <20140618102957.15728.43525.stgit@patser>
 <20140618103653.15728.4942.stgit@patser> <20140619011327.GC10921@kroah.com>
 <CAF6AEGv4Ms+zsrEtpA10bGq04LnRjzVb925co49eVxh4ugkd=A@mail.gmail.com>
 <20140619170059.GA1224@kroah.com>
 <CAKMK7uFa57YjeJCFQhWFr_5cRTTpWxBdJ1qtb5Ojnu-KZpe-Lw@mail.gmail.com>
 <20140619200159.GA27883@kroah.com> <53A366B3.8020808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53A366B3.8020808@zytor.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 2014-06-19 at 15:39 -0700, H. Peter Anvin wrote:
> On 06/19/2014 01:01 PM, Greg KH wrote:
> > On Thu, Jun 19, 2014 at 09:15:36PM +0200, Daniel Vetter wrote:
> >> On Thu, Jun 19, 2014 at 7:00 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>>> +     BUG_ON(f1->context != f2->context);
> >>>>>
> >>>>> Nice, you just crashed the kernel, making it impossible to debug or
> >>>>> recover :(
> >>>>
> >>>> agreed, that should probably be 'if (WARN_ON(...)) return NULL;'
> >>>>
> >>>> (but at least I wouldn't expect to hit that under console_lock so you
> >>>> should at least see the last N lines of the backtrace on the screen
> >>>> ;-))
> >>>
> >>> Lots of devices don't have console screens :)
> >>
> >> Aside: This is a pet peeve of mine and recently I've switched to
> >> rejecting all patch that have a BUG_ON, period.
> > 
> > Please do, I have been for a few years now as well for the same reasons
> > you cite.
> > 
> 
> I'm actually concerned about this trend.  Downgrading things to WARN_ON
> can allow a security bug in the kernel to continue to exist, for
> example, or make the error message disappear.

Me too.  We use BUG_ON in the I/O subsystem where we're forced to
violate a guarantee.  When the choice is corrupt something or panic the
system, I prefer the latter every time.

> I am wondering if the right thing here isn't to have a user (command
> line?) settable policy as to how to proceed on an assert violation,
> instead of hardcoding it at compile time.

I'd say it depends on the consequence of the assertion violation.  We
have assertions that are largely theoretical, ones that govern process
internal state (so killing the process mostly sanitizes the system) and
a few that imply data loss or data corruption.

James
