From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [Part1 PATCH v4 15/17] percpu: introduce
 DEFINE_PER_CPU_UNENCRYPTED
Date: Wed, 20 Sep 2017 11:16:10 -0500
Message-ID: <62e57a05-cbcf-4727-bca2-af93b4c87ab2@amd.com>
References: <20170916123418.37807-1-brijesh.singh@amd.com>
 <20170916123418.37807-16-brijesh.singh@amd.com>
 <20170919103906.GM4733@nazgul.tnic>
 <c17b7ac8-961b-8e3f-902f-40b18b80c993@amd.com>
 <20170920073426.GA26073@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170920073426.GA26073@nazgul.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On 09/20/2017 02:34 AM, Borislav Petkov wrote:
> On Tue, Sep 19, 2017 at 08:50:20AM -0500, Brijesh Singh wrote:
>> "..shared_aligned" section does not start and end with page-size alignment.
> 
> Nowhere in the code there's a comment saying: "This percpu section really must
> be page-size aligned because <reasons>." You need to be more verbose
> with requirements like that.
> 

I will add that comment.


> Also, you're ending up needing a whole page per-CPU for those variables.
> And now with the alignment before and after, you have worst-case two
> pages fragmentation of percpu memory and percpu memory is a rather
> limited resource AFAIR.
> 
> If only there were a alloc_percpu_page()...
> 
>> Since the C-bit works on PAGE_SIZE alignment hence the "..unencrypted" section
> 
> Btw, call that section "..decrypted" and everywhere do
> s/unencrypted/decrypted/g.
> 

Will do


>> starts and ends with page-size alignment. The closest I can find is
>> "..page_aligned" but again it does not end with page-size alignment.
>>
>> Additionally, since we clear the C-bit from unencrypted section hence we
>> should avoid overloading the existing section -- we don't want to expose more
>> than we wish.
> 
> Add that to the comment too.
> 

Will do
