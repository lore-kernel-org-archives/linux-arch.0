Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:18313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264505AbUEMUfW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 16:35:22 -0400
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i4DKZLJ11429
	for <linux-arch@vger.kernel.org>; Thu, 13 May 2004 13:35:21 -0700
Date: Thu, 13 May 2004 13:37:59 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: atomic ops for a VM fix
Message-Id: <20040513133759.7416ea42.akpm@osdl.org>
In-Reply-To: <20040513133526.0e5efed3.akpm@osdl.org>
References: <20040513133526.0e5efed3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

oh, and open-coded references to page->count are deliberately
broken at compile time.  Please convert any leftovers to get_page(),
set_page_count(), page_count() and __put_page(), thanks.
