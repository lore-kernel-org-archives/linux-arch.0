From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/34] arch: barrier cleanup + __smp_XXX barriers for virt
Date: Wed, 30 Dec 2015 14:49:53 +0100
Message-ID: <11919001.9WHgFoPpmK@wuerfel>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-arch@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 30 December 2015 15:24:12 Michael S. Tsirkin wrote:
> This is really trying to cleanup some virt code, as suggested by Peter, who
> said
> > You could of course go fix that instead of mutilating things into
> > sort-of functional state.
> 
> This work is needed for virtio, so it's probably easiest to
> merge it through my tree - is this fine by everyone?
> Arnd, if you agree, could you ack this please?

I've looked over all patches now, and everything seems fine (I had one
small comment about a duplicate patch). It's a very nice cleanup, both
for using the asm-generic file, and for the virtualization users.

Please add my "Acked-by: Arnd Bergmann <arnd@arndb.de>" when merging the
series through your tree.

	Arnd
