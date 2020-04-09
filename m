From: Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH 03/35] docs: fix broken references to text files
Date: Thu, 09 Apr 2020 09:07:13 +0200
Message-ID: <2427906.fv9odQMh6t@harkonnen>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kvm@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Akira Yokosawa <akiyks@gmail.com>, dri-devel@lists.freedesktop.org, linux-unionfs@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org, David Airlie <airlied@linux.ie>, Doug Ledford <dledford@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org, Jade Alglave <j.alglave@ucl.ac.uk>, Daniel Lustig <dlustig@nvidia.com>, Mike Leach <mike.leach@lin>
List-Id: linux-arch.vger.kernel.org

On Wednesday, April 8, 2020 5:45:55 PM CEST Mauro Carvalho Chehab wrote:
> Several references got broken due to txt to ReST conversion.
> 
> Several of them can be automatically fixed with:
> 
> 	scripts/documentation-file-ref-check --fix
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> #
> hwtracing/coresight/Kconfig Signed-off-by: Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org>
> ---
>  Documentation/memory-barriers.txt                    |  2 +-
>  Documentation/process/submit-checklist.rst           |  2 +-
>  .../translations/it_IT/process/submit-checklist.rst  |  2 +-

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>
