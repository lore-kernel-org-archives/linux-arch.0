From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: Arch specific mmap attributes (Was: mprotect pgprot handling weirdness)
Date: Tue,  6 Apr 2010 19:26:01 +0900 (JST)
Message-ID: <20100406185246.7E63.A69D9226@jp.fujitsu.com>
References: <20100406151751.7E4E.A69D9226@jp.fujitsu.com> <1270539044.13812.65.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52781 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0DFK0I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 06:26:08 -0400
In-Reply-To: <1270539044.13812.65.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-mm@kvack.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

> Ok, I see. No biggie. The main deal remains how we want to do that
> inside the kernel :-) I think the less horrible options here are
> to either extend vm_flags to always be 64-bit, or add a separate
> vm_map_attributes flag, and add the necessary bits and pieces to
> prevent merge accross different attribute vma's.

vma->vm_flags already have VM_SAO. Why do we need more flags?
At least, I dislike to add separate flags member into vma.
It might introduce unnecessary messy into vma merge thing.



> The more I try to hack it into vm_page_prot, the more I hate that
> option.
