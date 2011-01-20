From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Request for unicore32 architecture codes to merge into
 linux-next
Date: Thu, 20 Jan 2011 11:42:16 -0800
Message-ID: <20110120114216.4b23182a@jbarnes-desktop>
References: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cpoproxy3-pub.bluehost.com ([67.222.54.6]:60804 "HELO
	cpoproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750894Ab1ATTtA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Jan 2011 14:49:00 -0500
In-Reply-To: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: sfr@canb.auug.org.au, Arnd Bergmann <arnd@arndb.de>, gregkh@suse.de, dmitry.torokhov@gmail.com, dtor@mail.ru, rubini@cvml.unipv.it, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org

On Sun, 16 Jan 2011 01:00:31 +0800
"Guan Xuetao" <guanxuetao@mprc.pku.edu.cn> wrote:

> Hi,
> 
> I want to merge unicore32 repo into linux-next tree, the position is (unicore32 branch):
>   git://git.kernel.org/pub/scm/linux/kernel/git/epip/linux-2.6-unicore32.git
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---

Took a quick look at the PCI parts, looks like you have a pretty big
DMA restriction.

You could provide your own dma map ops and make the allocator a bit
smarter about where it gets memory (preferentially allocating from the
DMA'able region, which you could hide).  Or do you find that swiotlb
does ok in general?

Other than that you had pretty tiny bits of enabling code, I assume
they work on your platform (config space access & setup, etc.).

-- 
Jesse Barnes, Intel Open Source Technology Center
