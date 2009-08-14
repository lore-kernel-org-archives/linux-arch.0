From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 14/20] vmalloc: implement pcpu_get_vm_areas()
Date: Fri, 14 Aug 2009 15:07:30 +0900
Message-ID: <4A84FF22.9040008@kernel.org>
References: <1248171979-29166-1-git-send-email-tj@kernel.org> <1248171979-29166-15-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58120 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbZHNGIc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 02:08:32 -0400
In-Reply-To: <1248171979-29166-15-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.comc

Tejun Heo wrote:
...
> +	vmap_area_pcpu_hole = base + offsets[last_area];
> +
> +	spin_unlock(&vmap_area_lock);
> +
> +	/* insert all vm's */
> +	for (area = 0; area < nr_vms; area++)
> +		insert_vmalloc_vm(vms[area], vas[area], 0,
> +				  pcpu_get_vm_areas);

Changed the flags argument from 0 to VM_ALLOC.

Thanks.

-- 
tejun
