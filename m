From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Wed, 29 Jan 2020 20:04:40 +0100
Message-ID: <8736by84on.fsf@oldenburg2.str.redhat.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
        <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727515AbgA2TEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 14:04:54 -0500
In-Reply-To: <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com> (Dave Hansen's
        message of "Wed, 22 Jan 2020 10:45:27 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org

* Dave Hansen:

> Still doesn't build for me:
>
>> # make
>> make --no-builtin-rules ARCH=x86_64 -C ../../../.. headers_install
>> make[1]: Entering directory '/home/dave/linux.git'
>>   INSTALL ./usr/include
>> make[1]: Leaving directory '/home/dave/linux.git'
>> make: *** No rule to make target '/home/dave/linux.git/tools/testing/selftests/vm/protection_keys_32', needed by 'all'.  Stop.

Do you have 32-bit libraries installed?

Thanks,
Florian
