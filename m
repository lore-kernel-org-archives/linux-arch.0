From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_xxx barriers for virt
Date: Wed, 30 Dec 2015 15:46:46 -0500 (EST)
Message-ID: <20151230.154646.596597479469584255.davem@davemloft.net>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
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
Date: Wed, 30 Dec 2015 14:58:19 +0200

> -. Patch 1 documents the __smp APIs, and explains why they are
>    useful for virt

If virt is doing things like interacting with descriptors that are
shared with a (potentially SMP) host, why don't we just annotate those
specific cases?

The other memory barriers in the kernel do not matter for SMP'ness
when build UP.
