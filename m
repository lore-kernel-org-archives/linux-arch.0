From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 0/9] Updated fence patch series
Date: Mon, 7 Jul 2014 15:23:17 +0200
Message-ID: <CAKMK7uHZQjQ2m7KE22kTRVs-NtGguHREk24pSJiLbN7EoQLZ=g@mail.gmail.com>
References: <20140701103432.12718.82795.stgit@patser>
 <20140702053758.GA7578@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140702053758.GA7578@kroah.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 2, 2014 at 7:37 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> Android can expose fences to userspace. It's possible to make the new fence
>> mechanism expose the same fences to userspace by changing sync_fence_create
>> to take a struct fence instead of a struct sync_pt. No other change is needed,
>> because only the fence parts of struct sync_pt are used. But because the
>> userspace fences are a separate problem and I haven't really looked at it yet
>> I feel it should stay in staging, for now.
>
> Ok, that's reasonable.
>
> At first glance, this all looks "sane" to me, any objection from anyone
> if I merge this through my driver-core tree for 3.17?

Ack from my side fwiw.

Just for the record (again) about android syncpts. I think using
android syncpts stuff as the official userspace interfaces for fences
for userspace that wants to do explicit syncing is the sane approach -
after all the (only) big platform using explicit fencing is Android
since opencl is kinda not yet there really on linux (which would be
the other guy really interested in explicit fencing).

But before we de-stage android syncpts (and so bake in the userspace
abi forever) I really want to see a full upstream gpu driver
implementation using fences and running on both X+DRI userspace
(implicit syncing) and android (expclicit syncing), including good
test coverage for corner-cases to make sure we've addressed all warts
and hidden dragons. i915 looks like the most likely candidate to get
there first (we have the code for both use-cases out-of-tree after
all) so I'll keep on pestering people. No promises though ;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
