From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Mon, 06 Nov 2017 22:28:41 +0100
Message-ID: <87efpbm706.fsf@mid.deneb.enyo.de>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com> (Ram
        Pai's message of "Mon, 6 Nov 2017 00:56:52 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

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
