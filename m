From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Fri, 11 Dec 2009 00:43:01 +0300
Message-ID: <20091211004301.6e72bfd2.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
	<20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
	<20091210023609.b8c9bd34.isloginov@gmail.com>
	<1260402471.14369.60.camel@mulgrave.site>
	<20091210030638.db4cfd8a.isloginov@gmail.com>
	<1260404395.14369.68.camel@mulgrave.site>
	<20091210074020.a7c36c32.isloginov@gmail.com>
	<1260464851.2457.98.camel@mulgrave.site>
	<20091210224637.cb9712f7.isloginov@gmail.com>
	<1260476884.2457.116.camel@mulgrave.site>
	<20091210234816.5aca535e.isloginov@gmail.com>
	<1260478776.2457.141.camel@mulgrave.site>
	<20091211002700.0600d327.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64523 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761043AbZLJVnA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:43:00 -0500
Received: by ewy19 with SMTP id 19so341318ewy.21
        for <linux-arch@vger.kernel.org>; Thu, 10 Dec 2009 13:43:05 -0800 (PST)
In-Reply-To: <20091211002700.0600d327.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Ilya Loginov <isloginov@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Fri, 11 Dec 2009 00:27:00 +0300
Ilya Loginov <isloginov@gmail.com> wrote:

> Second. What difference will be between flush_kernel_dcache_page and
> flush_dcache_page on MIPS? In common, flush_dcache_page in MIPS set 
> bit dirty on page.

Sorry. It is stupid question.

-- 
Ilya Loginov <isloginov@gmail.com>
