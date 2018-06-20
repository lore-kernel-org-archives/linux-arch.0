Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12746 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbeFTO5O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 10:57:14 -0400
Subject: Re: [PATCH v13 14/24] selftests/vm: generic cleanup
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-15-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e50fa00b-724e-ebcb-38b4-22cad9bee1c5@intel.com>
Date: Wed, 20 Jun 2018 07:57:11 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-15-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620145711.LJbfriLhJBOBKmBcMZ9f87jRHiUKjr-cYu2DPSBFW4I@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> cleanup the code to satisfy coding styles.

A lot of this makes the code look worse and more unreadable than before.
 I think someone just ran it through lindent or something.

I also took a few CodingStyle liberties in here because it's _not_ main
kernel code.  I think the occasional 85-column line is probably OK in here.
