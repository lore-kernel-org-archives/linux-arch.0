Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:22828 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753885AbeFTPWH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 11:22:07 -0400
Subject: Re: [PATCH v13 24/24] selftests/vm: test correct behavior of pkey-0
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-25-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0a7c79a9-8d2d-09cb-30c6-f0f7bca526db@intel.com>
Date: Wed, 20 Jun 2018 08:22:05 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-25-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620152205.La7Sbp4by3gJnuzNqxKCGop5cWSKzFiUBwg3FGlA3Zo@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> Ensure pkey-0 is allocated on start.  Ensure pkey-0 can be attached
> dynamically in various modes, without failures.  Ensure pkey-0 can be
> freed and allocated.

I like this.  Looks very useful.

Acked-by: Dave Hansen <dave.hansen@intel.com>
