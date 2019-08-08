From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 16:20:51 +0000
Message-ID: <d487294a-43b0-45ca-93ea-dcff1c2b022a@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Content-Language: en-US
Content-ID: <F8DD9C09E60D9E4589E7C3CCF10A847A@eurprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Hansen <dave.hansen@intel.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, Will Deacon <Will.Deacon@arm.com>, nd <nd@arm.com>
List-Id: linux-arch.vger.kernel.org

On 07/08/2019 21:38, Dave Hansen wrote:
> On 8/7/19 8:53 AM, Catalin Marinas wrote:
>> +- mmap() done by the process itself (or its parent), where either:
>> +
>> +  - flags have the **MAP_ANONYMOUS** bit set
>> +  - the file descriptor refers to a regular file (including those returned
>> +    by memfd_create()) or **/dev/zero**
> 
> What's a "regular file"? ;)

i'd expect the posix definition.

in posix "File types include regular file, character
special file, block special file, FIFO special file,
symbolic link, socket, and directory. Other types of
files may be supported by the implementation."

where regular file is "A file that is a randomly
accessible sequence of bytes, with no further
structure imposed by the system."
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_323
