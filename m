From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for virt
Date: Wed, 30 Dec 2015 16:59:08 -0500 (EST)
Message-ID: <20151230.165908.1627575055770897057.davem@davemloft.net>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<20151230.154646.596597479469584255.davem@davemloft.net>
	<20151230224855-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151230224855-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, stefano.stabellini@eu.citrix.com, peterz@infradead.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 23:36:29 +0200

> On Wed, Dec 30, 2015 at 03:46:46PM -0500, David Miller wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>> Date: Wed, 30 Dec 2015 14:58:19 +0200
>> 
>> > -. Patch 1 documents the __smp APIs, and explains why they are
>> >    useful for virt
>> 
>> If virt is doing things like interacting with descriptors that are
>> shared with a (potentially SMP) host, why don't we just annotate those
>> specific cases?
> 
> Using a bunch of per-arch ifdefs in virtio?
> That's fundamentally what we have now.

I was suggesting a generic interface to get what you want.

virt_mb() or something like that.  You can name it something
else, that's not the important part.

> Or do you mean wrappers for __smp_XXX that explicitly
> say they are for talking to host?
> E.g. pv_mb() pv_rmb() etc.
> That sounds very reasonable to me.

Exactly!
