Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:33049 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753885AbeFTPJP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 11:09:15 -0400
Subject: Re: [PATCH v13 17/24] selftests/vm: powerpc implementation to check
 support for pkey
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-18-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <20bc9696-3ae9-4eb9-40ce-9c477a8aaea2@intel.com>
Date: Wed, 20 Jun 2018 08:09:12 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-18-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620150912._uDeIhzFyOk8ybK6g6BEKzCEJnBZrLKJiKE53ux84zM@z>

> -	if (cpu_has_pku()) {
> -		dprintf1("SKIP: %s: no CPU support\n", __func__);
> +	if (is_pkey_supported()) {
> +		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
>  		return;
>  	}

I actually kinda wanted a specific message for when the *CPU* doesn't
support the feature.
