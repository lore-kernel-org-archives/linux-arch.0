From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Tue, 7 Nov 2017 14:47:10 -0800
Message-ID: <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
 <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, Florian Weimer <fw@deneb.enyo.de>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On 11/07/2017 02:39 PM, Ram Pai wrote:
> 
> As per the current semantics of sys_pkey_free(); the way I understand it,
> the calling thread is saying disassociate me from this key.

No.  It is saying: "this *process* no longer has any uses of this key,
it can be reused".

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
