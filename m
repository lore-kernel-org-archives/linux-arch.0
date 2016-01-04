From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH 31/34] xenbus: use __smp_XXX barriers
Date: Mon, 4 Jan 2016 11:58:53 +0000
Message-ID: <alpine.DEB.2.02.1601041143591.19710@kaball.uk.xensource.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-32-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451473761-30019-32-git-send-email-mst@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 30 Dec 2015, Michael S. Tsirkin wrote:
> drivers/xen/xenbus/xenbus_comms.c uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to __smp_XXX barriers which serve this exact purpose.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


> This is straight-forward, but untested.
> I can either merge this patchset through my tree if this is
> acked, or defer this and merge the patchset first,
> and xen bits through xen tree afterwards.
> 
> Pls let me know.

I think it can go via your tree. However you have missed a few Xen
source files which need the same mb/__smb_mb conversions:

drivers/xen/grant-table.c
drivers/xen/evtchn.c
drivers/xen/events/events_fifo.c
drivers/xen/xen-scsiback.c
drivers/xen/tmem.c
drivers/xen/xen-pciback/pci_stub.c
drivers/xen/xen-pciback/pciback_ops.c


>  drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index fdb0f33..09b17c7 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must write data /after/ reading the consumer index. */
> -		mb();
> +		__smp_mb();
>  
>  		memcpy(dst, data, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see new producer until data is there. */
> -		wmb();
> +		__smp_wmb();
>  		intf->req_prod += avail;
>  
>  		/* Implies mb(): other side will see the updated producer. */
> @@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must read data /after/ reading the producer index. */
> -		rmb();
> +		__smp_rmb();
>  
>  		memcpy(data, src, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see free space until we've copied out */
> -		mb();
> +		__smp_mb();
>  		intf->rsp_cons += avail;
>  
>  		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
> -- 
> MST
> 
