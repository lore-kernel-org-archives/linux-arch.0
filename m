Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH v18 00/24] selftests, powerpc, x86: Memory Protection Keys
References: <cover.1580365432.git.sandipan@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
Date: Thu, 30 Jan 2020 13:51:45 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200130215145.w8gnYEk-DhlmYfUe3-anCMN0U-Ms3jVP7Q5Q_DHbW9g@z>

On 1/29/20 10:36 PM, Sandipan Das wrote:
> v18:
> 	(1) Fixed issues with x86 multilib builds based on
> 	    feedback from Dave.
> 	(2) Moved patch 2 to the end of the series.

These (finally) build and run successfully for me on an x86 system with
protection keys.  Feel free to add my Tested-by, and Acked-by.

FWIW, I don't think look perfect, but my standards are lower for
selftests/ than normal kernel code. :)
