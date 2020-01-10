From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Fri, 10 Jan 2020 09:57:43 -0800
Message-ID: <4a35bf48-d191-4e42-ea47-f419895ed876@intel.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <87y2ufxlci.fsf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12106 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgAJR56 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 12:57:58 -0500
In-Reply-To: <87y2ufxlci.fsf@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, bauerman@linux.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au

On 1/10/20 9:38 AM, Aneesh Kumar K.V wrote:
>> v15:
>> 	(1) Rebased on top of latest master.
>> 	(2) Addressed review comments from Dave Hansen.
>> 	(3) Moved code for getting or setting pkey bits to new
>> 	    helpers. These changes replace patch 7 of v14.
>> 	(4) Added a fix which ensures that the correct count of
>> 	    reserved keys is used across different platforms.
>> 	(5) Added a fix which ensures that the correct page size
>> 	    is used as powerpc supports both 4K and 64K pages.
>>
> Any update on merging this series? Can Intel help with testing this
> series on Skylake server? Possibly merging to -next will result in
> automated 01.org tests?

Could you dump these in a git tree, please?  It will make it a wee bit
easier for me to ship the resulting tree around to a couple different
systems.
