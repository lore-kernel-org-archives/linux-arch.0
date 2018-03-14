Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14171 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeCNOIc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 10:08:32 -0400
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
 <20180309200017.GR1060@ram.oc3035372033.ibm.com>
 <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b525f67d-8b79-56c1-2eed-292a806d9202@intel.com>
Date: Wed, 14 Mar 2018 07:08:29 -0700
MIME-Version: 1.0
In-Reply-To: <f71b583f-2b66-e9ed-b08b-fddff228a5a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Message-ID: <20180314140829.ldCNh-p70pAkVHw4jQ6TYF0Z9xnmyRiWKD0mpKDDdI4@z>

On 03/14/2018 01:00 AM, Florian Weimer wrote:
> ... but not the key which is used for PROT_EXEC emulation, which is still
> reserved

The PROT_EXEC key is dynamically allocated.  There is no "the key".
