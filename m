From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv1 000/211] unicore32 architecture support
Date: Thu, 09 Dec 2010 10:50:42 +0100
Message-ID: <4D00A672.9050906@kernel.org>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34161 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab0LIJuu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Dec 2010 04:50:50 -0500
In-Reply-To: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 12/09/2010 10:28 AM, Guan Xuetao wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> 
> These patches add support for UniCore-32 ISA in linux kernel.
> UniCore ISA is defined and developed by Micro-Processor R&D Center of
> Peking University, and over the years, the CPUs and SoCs using UniCore ISA
> have been successfully applied in a variety of products in China.

* Patches should be split according to logical steps of changes, not
  per-file.

* Patches should be bisectable.  IOW, after applying upto any patch in
  the series, the tree should be buildable and working.

* When posting a patch series, especially one as large as 211, please
  make the mails for the actual patches replies to the head message.
  Don't post it as 212 separate messages or replies to the immediate
  previous patch.

So, in short, if you're adding a whole new arch, just post it as a
single patch or a series of several patches if it requires changes
outside of the specific arch subtree.

Thanks.

-- 
tejun
