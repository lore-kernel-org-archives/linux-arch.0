Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44785 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765774AbdAKQdf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jan 2017 11:33:35 -0500
Subject: Re: [PATCH v4 0/4] Application Data Integrity feature introduced by
 SPARC M7
References: <cover.1483999591.git.khalid.aziz@oracle.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
Date: Wed, 11 Jan 2017 08:33:30 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1483999591.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Message-ID: <20170111163330.Cuq7-8prCXRBQO9o0LaJEUHfyDBEGVGjGXP4yyhfGZ0@z>

On 01/11/2017 08:12 AM, Khalid Aziz wrote:
> A userspace task enables ADI through mprotect(). This patch series adds
> a page protection bit PROT_ADI and a corresponding VMA flag
> VM_SPARC_ADI. VM_SPARC_ADI is used to trigger setting TTE.mcd bit in the
> sparc pte that enables ADI checking on the corresponding page.

Is there a cost in the hardware associated with doing this "ADI
checking"?  For instance, instead of having this new mprotect()
interface, why not just always set TTE.mcd on all PTEs?

Also, should this be a privileged interface in some way?  The hardware
is storing these tags *somewhere* and that storage is consuming
resources *somewhere*.  What stops a crafty attacker from mmap()'ing a
128TB chunk of the zero pages and storing ADI tags for all of it?
That'll be 128TB/64*4bits = 1TB worth of 4-bit tags.  Page tables, for
instance, consume a comparable amount of storage, but the OS *knows*
about those and can factor them into OOM decisions.
