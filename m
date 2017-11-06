Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from albireo.enyo.de ([5.158.152.32]:46176 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdKFVfZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Nov 2017 16:35:25 -0500
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Date: Mon, 06 Nov 2017 22:28:41 +0100
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com> (Ram
        Pai's message of "Mon, 6 Nov 2017 00:56:52 -0800")
Message-ID: <87efpbm706.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20171106212841.MzZj9s1swTqq14cQbLRGboqwLpmiZ-Ustg-It3zmfoY@z>

* Ram Pai:

> Testing:
> -------
> This patch series has passed all the protection key
> tests available in the selftest directory.The
> tests are updated to work on both x86 and powerpc.
> The selftests have passed on x86 and powerpc hardware.

How do you deal with the key reuse problem?  Is it the same as x86-64,
where it's quite easy to accidentally grant existing threads access to
a just-allocated key, either due to key reuse or a changed init_pkru
parameter?

What about siglongjmp from a signal handler?

  <https://sourceware.org/bugzilla/show_bug.cgi?id=22396>

I wonder if it's possible to fix some of these things before the exact
semantics of these interfaces are set in stone.
