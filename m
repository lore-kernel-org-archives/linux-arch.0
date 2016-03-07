Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51331 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcCGQ4c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 11:56:32 -0500
Date: Mon, 07 Mar 2016 11:56:26 -0500 (EST)
Message-ID: <20160307.115626.807716799249471744.davem@davemloft.net>
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
From: David Miller <davem@davemloft.net>
In-Reply-To: <56DD9949.1000106@oracle.com>
References: <1456951177-23579-1-git-send-email-khalid.aziz@oracle.com>
	<20160305.230702.1325379875282120281.davem@davemloft.net>
	<56DD9949.1000106@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: khalid.aziz@oracle.com
Cc: corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, zhenzhang.zhang@huawei.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, rob.gardner@oracle.com, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160307165626.CICeMzCGdyMYQTj4HkC6Hhr0JmLq5BuxnJMme7YZbVU@z>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 7 Mar 2016 08:07:53 -0700

> PR_GET_SPARC_ADICAPS

Put this into a new ELF auxiliary vector entry via ARCH_DLINFO.

So now all that's left is supposedly the TAG stuff, please explain
that to me so I can direct you to the correct existing interface to
provide that as well.

Really, try to avoid prtctl, it's poorly typed and almost worse than
ioctl().
