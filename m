Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7861 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbdAFPg4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Jan 2017 10:36:56 -0500
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
References: <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
 <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
 <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
 <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
 <db31d324-a1ae-7450-0e54-ad98da205773@linux.intel.com>
 <5a0270ea-b29a-0751-a27f-2412a8588561@oracle.com>
 <7532a1d6-6562-b10b-dacd-931cb2a9e536@linux.intel.com>
 <92d55a69-b400-8461-53a1-d505de089700@oracle.com>
 <75c31c99-cff7-72dc-f593-012fe5acd405@linux.intel.com>
 <7fbc4ca1-22ef-8ef5-5c1b-dd075852e512@oracle.com>
 <20170106091934.GF5556@dhcp22.suse.cz>
 <ac86aa55-964d-56a1-1381-c208de78b24e@oracle.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <f33f2c3c-4ec5-423c-5d13-a4b9ab8f7a95@linux.intel.com>
Date: Fri, 6 Jan 2017 07:36:53 -0800
MIME-Version: 1.0
In-Reply-To: <ac86aa55-964d-56a1-1381-c208de78b24e@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, Michal Hocko <mhocko@kernel.org>
Cc: Rob Gardner <rob.gardner@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid@gonehiking.org>
Message-ID: <20170106153653.gvv_yTxQAlbbszFdMLM-wGR0weB8972vhXnI44fXXzo@z>

On 01/06/2017 07:32 AM, Khalid Aziz wrote:
> I agree with you on simplicity first. Subpage granularity is complex,
> but the architecture allows for subpage granularity. Maybe the right
> approach is to support this at page granularity first for swappable
> pages and then expand to subpage granularity in a subsequent patch?
> Pages locked in memory can already use subpage granularity with my patch.

What do you mean by "locked in memory"?  mlock()'d memory can still be
migrated around and still requires "swap" ptes, for instance.
