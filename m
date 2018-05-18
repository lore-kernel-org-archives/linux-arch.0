From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
	implementation
Date: Fri, 18 May 2018 13:03:46 +0000
Message-ID: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511075945.16548-3-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <994FD47D919A664AB275AA5865AC4C92-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On Fri, 2018-05-11 at 09:59 +0200, Christoph Hellwig wrote:

[snip]

There seems to be one subtle issue with map/unmap code.
While investigating problems on ARC I added instrumentation as below:
---------------------------------------->8------------------------------------
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -152,14 +152,37 @@ static void _dma_cache_sync(struct device *dev, phys_addr_t paddr, size_t size,
        }
 }
 
+static const char *dir_to_str(enum dma_data_direction dir)
+{
+       switch (dir) {
+       case DMA_BIDIRECTIONAL: return "DMA_BIDIRECTIONAL";
+       case DMA_TO_DEVICE: return "DMA_TO_DEVICE";
+       case DMA_FROM_DEVICE: return "DMA_FROM_DEVICE";
+       case DMA_NONE: return "DMA_NONE";
+       default: return "WRONG_VALUE!";
+       }
+}
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
                size_t size, enum dma_data_direction dir)
 {
+       if (dir != DMA_TO_DEVICE){
+               dump_stack();
+               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
+                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_TO_DEVICE));
+       }
+
        return _dma_cache_sync(dev, paddr, size, dir);
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
                size_t size, enum dma_data_direction dir)
 {
+       if (dir != DMA_FROM_DEVICE) {
+               dump_stack();
+               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
+                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_FROM_DEVICE));
+       }
+
        return _dma_cache_sync(dev, paddr, size, dir);
 }
---------------------------------------->8------------------------------------

And with that I noticed a bit unexpected output, see below:
---------------------------------------->8------------------------------------
Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  dump_stack+0x68/0x80
  arch_sync_dma_for_device+0x34/0xc4
  dma_noncoherent_map_sg+0x80/0x94
  __dw_mci_start_request+0x1ee/0x868
  dw_mci_request+0x17e/0x1c8
  mmc_wait_for_req+0x106/0x1ac
  mmc_app_sd_status+0x108/0x130
  mmc_sd_setup_card+0xc6/0x2e8
  mmc_attach_sd+0x1b6/0x394
  mmc_rescan+0x2f4/0x3bc
  process_one_work+0x194/0x348
  worker_thread+0xf2/0x478
  kthread+0x120/0x13c
  ret_from_fork+0x18/0x1c
 *** arch_sync_dma_for_device@172: DMA direction is DMA_FROM_DEVICE instead of DMA_TO_DEVICE
...
Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  dump_stack+0x68/0x80
  arch_sync_dma_for_device+0x34/0xc4
  dma_noncoherent_map_page+0x86/0x8c
  usb_hcd_map_urb_for_dma+0x49e/0x53c
  usb_hcd_submit_urb+0x43c/0x8c4
  usb_control_msg+0xbe/0x16c
  hub_port_init+0x5e0/0xb0c
  hub_event+0x4e6/0x1164
  process_one_work+0x194/0x348
  worker_thread+0xf2/0x478
  kthread+0x120/0x13c
  ret_from_fork+0x18/0x1c
 mmcblk0: p1 p2
 *** arch_sync_dma_for_device@172: DMA direction is DMA_FROM_DEVICE instead of DMA_TO_DEVICE

...
and quite some more of the similar
...
---------------------------------------->8------------------------------------

In case of MMC/DW_MCI (AKA DesignWare MobileStorage controller) that's an execution flow:
1) __dw_mci_start_request()
2) dw_mci_pre_dma_transfer()
3) dma_map_sg(..., mmc_get_dma_dir(data))

Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().

I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.


> +static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page,
> +		unsigned long offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	dma_addr_t addr;
> +
> +	addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> +	if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +	return addr;
> +}
> +
> +static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	nents = dma_direct_map_sg(dev, sgl, nents, dir, attrs);
> +	if (nents > 0 && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_sg_for_device(dev, sgl, nents, dir);
> +	return nents;
> +}

The same is for unmap functions.
My guess is we need to respect direction in map/unmap functions and use
either dma_noncoherent_sync_single_for_cpu(..., DMA_FROM_DEVICE) or
dma_noncoherent_sync_single_for_device(...,DMA_TO_DEVICE).


> +static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_single_for_cpu(dev, addr, size, dir);
> +}
> +
> +static void dma_noncoherent_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_noncoherent_sync_sg_for_cpu(dev, sgl, nents, dir);
> +}
> +#endif

But the real fix of my problem is:
---------------------------------------->8------------------------------------
--- a/lib/dma-noncoherent.c
+++ b/lib/dma-noncoherent.c
@@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
 
        addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
        if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
+               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
        return addr;
 }
---------------------------------------->8------------------------------------

You seem to lost an offset in the page so if we happen to have a buffer not aligned to
a page boundary then we were obviously corrupting data outside our data :)

-Alexey
