Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:59093 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbcCHEYY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 23:24:24 -0500
Date: Mon, 07 Mar 2016 23:24:18 -0500 (EST)
Message-ID: <20160307.232418.1734056188463866385.davem@davemloft.net>
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
From: David Miller <davem@davemloft.net>
In-Reply-To: <56DE1AF1.40107@oracle.com>
References: <56DDC776.3040003@oracle.com>
	<20160307.141600.1873883635480850431.davem@davemloft.net>
	<56DE1AF1.40107@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: khalid.aziz@oracle.com
Cc: rob.gardner@oracle.com, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160308042418.JlUL-tTI-koT4KU9s8sJAmqUuBX4LzSnbV_91DwFm4g@z>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 7 Mar 2016 17:21:05 -0700

> Can we enable ADI support for swappable pages in a subsequent update
> after the core functionality is stable on mlock'd pages?

I already said no.
