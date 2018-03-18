From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature
 introduced by SPARC M7
Date: Sun, 18 Mar 2018 11:08:57 -0400 (EDT)
Message-ID: <20180318.110857.1660518649370410007.davem@davemloft.net>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khalid.aziz@oracle.com
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com, akpm@linux-foundation.org, allen.pais@oracle.com, aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com, arnd@arndb.de, benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com, david.j.aldridge@oracle.com, dwindsor@gmail.com, ebiederm@xmission.com, elena.reshetova@intel.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org, henry.willard@oracle.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com, jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de, khalid@gonehiking.org, khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org, ktkhai@virtuozzo.com, liam.mer
List-Id: linux-arch.vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 10:15:42 -0700

> V12 changes:
> This series is same as v10 and v11 and was simply rebased on 4.16-rc2
> kernel and patch 11 was added to update signal delivery code to use the
> new helper functions added by Eric Biederman. Can mm maintainers please
> review patches 2, 7, 8 and 9 which are arch independent, and
> include/linux/mm.h and mm/ksm.c changes in patch 10 and ack these if
> everything looks good? 

Khalid I've applied this series to sparc-next, thank you!

But one thing has to be fixed up.

In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
CONFIG_SPARC64.

That's not correct, you should never control user facing definitions
based upon kernel configuration.

Also, both 32-bit and 64-bit applications running on ADI capable
machines want to compile against and use this informaiton.

So please remove these CPP checks.
