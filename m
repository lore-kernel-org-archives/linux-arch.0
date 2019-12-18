Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33996 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfLRVBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 16:01:46 -0500
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
 <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
 <20191218205905.GG4113@kitsune.suse.cz>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
Date: Wed, 18 Dec 2019 13:01:46 -0800
MIME-Version: 1.0
In-Reply-To: <20191218205905.GG4113@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191218210146.2Eyeoa6kv4NUF-iKRuZK6XTcIVytA-ErFe-zD8FmwVU@z>

On 12/18/19 12:59 PM, Michal Suchánek wrote:
>> I'd really just rather do %016lx *everywhere* than sprinkle the
>> PKEY_REG_FMTs around.
> Does lx work with u32 without warnings?

Either way, I'd be happy to just make the x86 one u64 to make the whole
thing look more sane,
