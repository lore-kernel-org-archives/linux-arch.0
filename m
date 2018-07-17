From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
Date: Tue, 17 Jul 2018 10:56:08 -0700
Message-ID: <febe6668-c66a-4601-63da-44501faf12ee@intel.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
 <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
 <20180717161332.GH5790@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180717161332.GH5790@ram.oc3035372033.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, shuahkh@osg.samsung.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 07/17/2018 09:13 AM, Ram Pai wrote:
> I have incorporated almost all of your comments. But there are some
> comments that take some effort to implement. Shall we get the patches
> merged in the current form?  This code has been sitting out for a while.
> 
> In the current form its tested and works on powerpc and on x86, and
> incorporates about 95% of your suggestions. The rest I will take care
> as we go.

What constitutes the remaining 5%?
