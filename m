From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 13:56:49 -0300
Message-ID: <20200731165649.GG24045@ziepe.ca>
References: <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> > Your preservation-across-exec use-case might or might not need the
> > VMA to be mapped at the same address.  
> 
> It does.  qemu registers memory with vfio which remembers the va's in kernel
> metadata for the device.

Once the memory is registered with vfio the VA doesn't matter, vfio
will keep the iommu pointing at the same physical pages no matter
where they are mapped.

Jason
